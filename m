Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbULQQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbULQQlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbULQQlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:41:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261870AbULQQk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:40:58 -0500
Date: Fri, 17 Dec 2004 11:40:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] fork historic module
In-Reply-To: <a482d6bf04121708146f221b15@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0412171134220.14531-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any comments and suggestions are welcome.

I don't see why you are using LSM for this.

It's not an access control system, only uses one LSM hook (I gather
becuase it happens to be in the right place), and furthermore, uses a hook
intended for LSM resource management.



- James
-- 
James Morris
<jmorris@redhat.com>



