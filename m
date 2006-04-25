Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWDYJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWDYJcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDYJcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:32:32 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:10186 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932171AbWDYJcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:32:31 -0400
In-Reply-To: <8e724d49e74bc1155f4e.1145913780@eng-12.pathscale.com>
References: <8e724d49e74bc1155f4e.1145913780@eng-12.pathscale.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1687B2F9-E947-4400-872E-163133854E13@kernel.crashing.org>
Cc: rdreier@cisco.com, openib-general@openib.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4 of 13] ipath - change handling of PIO buffers
Date: Tue, 25 Apr 2006 11:32:24 +0200
To: "Bryan O'Sullivan" <bos@pathscale.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * The problem with this is that it's global, but we'll use different
> + * numbers for different chip types.  So the default value is not
> + * very useful.  I've redefined it for the 1.3 release so that it's

----------------------------------------------^^^
Change this to 2.6.17?

> + * zero unless set by the user to something else, in which case we
> + * try to respect it.


Segher

