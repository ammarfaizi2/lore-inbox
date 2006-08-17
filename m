Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWHQUas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWHQUas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWHQUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:30:48 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:60631 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1030254AbWHQUar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:30:47 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Date: Thu, 17 Aug 2006 22:30:30 +0200
User-Agent: KMail/1.9.3
Cc: =?iso-8859-1?q?=C9ric_Piel?= <Eric.Piel@lifl.fr>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-mips@linux-mips.org
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608142126.29171.thomas.koeller@baslerweb.com> <20060817153138.GE5950@ucw.cz>
In-Reply-To: <20060817153138.GE5950@ucw.cz>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172230.30682.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 17:31, Pavel Machek wrote:
> Well, I guess v4l api will need to be improved, then. That is still
> not a reason to introduce completely new api...

The API as implemented by the driver I submitted is very minimalistic,
because it is just a starting point. There's more to be added in future,
like controlling flashes, interfacing to line-scan cameras clocked by
incremental encodes attached to some conveyor, and other stuff which
is common in industrial image processing applications. You really do
not want to clutter the v4l2 API with these things; that would hardly
be an 'improvement'.

Different interfaces, designed to serve different purposes...

Thomas
-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
