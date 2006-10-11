Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWJKIM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWJKIM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWJKIM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:12:58 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:26544 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161024AbWJKIM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:12:57 -0400
Date: Wed, 11 Oct 2006 09:12:44 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Arjan van de Ven <arjan@infradead.org>, Yu Luming <luming.yu@gmail.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061011081244.GA6915@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <1160549944.3000.347.camel@laptopd505.fenrus.org> <20061011070412.GA6128@srcf.ucam.org> <200610111104.50563.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610111104.50563.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:04:48AM +0300, Ismail Donmez wrote:

> device_id:    0x0410
> type:         UNKNOWN
> known by bios: no

This one's an LCD, according to the spec. The id spec was changed 
slightly in 3.0 of the acpi spec (in a backwards compatible way) - I'd 
guess that the acpi video driver just hasn't been updated.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
