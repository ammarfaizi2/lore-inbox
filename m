Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030657AbWKOQ0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbWKOQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbWKOQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:26:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16547 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030657AbWKOQ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:26:42 -0500
Subject: Re: [PATCH] pci: Introduce pci_find_present
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061115162445.641eb321@localhost.localdomain>
References: <20061115162445.641eb321@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 17:26:39 +0100
Message-Id: <1163608000.31358.134.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 16:24 +0000, Alan wrote:
> This works like pci_dev_present but instead of returning boolean returns
> the matching pci_device_id entry. This makes it much more useful. Code
> bloat is basically nil as the old boolean function is rewritten in terms
> of the new one.
> 

shouldn't this take a refcount on the device (which the user of this
function then has to put again) ?



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

