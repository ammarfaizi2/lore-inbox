Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTD3W7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTD3W7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:59:37 -0400
Received: from pointblue.com.pl ([62.89.73.6]:20493 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262530AbTD3W7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:59:35 -0400
Subject: Re: [PATCH] ieee1394.c on - compilation errors
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Ben Collins <bcollins@debian.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030430224346.GA372@phunnypharm.org>
References: <1051743594.5267.7.camel@flat41>
	 <20030430224346.GA372@phunnypharm.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051744400.5274.12.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 00:13:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 23:43, Ben Collins wrote:

> Please inspect the logic before removing things :)
> 
> I already submitted a patch to Linus to fix this. The problem is that
> class_num was used as an opaque way of determining what sort of device
> (host/node/unitdir) it was dealing with on the ieee1394 bus. Your patch
> would likely cause a lot of oopses.
I wasn't sure about that. maybe i should ask for better way. :)

thanks for response.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

