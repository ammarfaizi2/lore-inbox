Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUJTRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUJTRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUJTRGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:06:52 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:23979 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S268464AbUJTQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:58:39 -0400
To: Tomas Carnecky <tom@dbservice.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: my opinion about VGA devices
In-Reply-To: <41767DB4.9040008@dbservice.com>
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org> <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com> <417672BF.5040708@dbservice.com> <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com> <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com> <41767DB4.9040008@dbservice.com>
Date: Wed, 20 Oct 2004 17:58:38 +0100
Message-Id: <E1CKJnK-0001BL-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky <tom@dbservice.com> wrote:

> Well... that's why I don't understand why we should keep the VGA code in 
> the kernel. It's very unlikely that the kernel crashes before a graphics 
> driver can be initialized (if you do this as soon as possible) unless 
> you have a bad CPU etc.

At the moment, it /is/ quite likely that the kernel crashes before a
graphics driver can be initialised if you're trying to resume from ACPI
S3.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
