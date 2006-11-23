Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933268AbWKWM0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbWKWM0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933600AbWKWM0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:26:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933268AbWKWM0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:26:05 -0500
Subject: Re: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
From: Arjan van de Ven <arjan@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Jason Gaston <jason.d.gaston@intel.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, i2c@lm-sensors.org
In-Reply-To: <20061123130938.5818ad16.khali@linux-fr.org>
References: <200611221519.12373.jason.d.gaston@intel.com>
	 <20061123130938.5818ad16.khali@linux-fr.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 13:25:57 +0100
Message-Id: <1164284758.31358.781.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 13:09 +0100, Jean Delvare wrote:
> Hi Jason,
> 
> On Wed, 22 Nov 2006 15:19:12 -0800, Jason Gaston wrote:
> > This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.
> > This patch relies on the irq ICH9 patch to pci_ids.h.
> 
> Looks good. Care to also update Documentation/i2c/busses/i2c-i801? I
> see it misses at least the ICH8 and ESB2 as well.
> 
> I would also appreciate an update to lm_sensors' sensors-detect script,
> if you could send a patch to the sensors list.


hmmm couldn't the sensors-detect script just at runtime look at the pci
tables in the modules? that way no need to duplicate/update all of this
in multiple places...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

