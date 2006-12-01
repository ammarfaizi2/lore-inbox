Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936524AbWLAToT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936524AbWLAToT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936539AbWLAToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:44:19 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:7878 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S936524AbWLAToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:44:17 -0500
X-Sasl-enc: aW1wxyDgBXEyKMzCcfYjzpldKkMubrR+qxe/Q5KNZdSH 1165002257
Date: Fri, 1 Dec 2006 17:43:37 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Message-ID: <20061201194337.GA7773@khazad-dum.debian.net>
References: <20061127174328.30e8856e.alessandro.guido@gmail.com> <20061201133520.GC4239@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201133520.GC4239@ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006, Pavel Machek wrote:
> Looks okay to me. We really want unified interface for backlight.

Then I request some help to get
http://article.gmane.org/gmane.linux.acpi.devel/19792
merged.

Without it, the backlight interface becomes annoying on laptops.  Your
screen will be powered off when you remove the modules providing the
backlight interface.  This is not consistent with the needs of laptop
backlight devices, or with the behaviour the drivers had before the
backlight sysfs support was added.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
