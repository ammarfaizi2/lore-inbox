Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933042AbWKMTdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbWKMTdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbWKMTdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:33:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932862AbWKMTdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:33:22 -0500
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
From: Arjan van de Ven <arjan@infradead.org>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 20:32:52 +0100
Message-Id: <1163446372.15249.190.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 19:56 +0100, Mathieu Fluhr wrote:
> On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
> > Mathieu Fluhr wrote:
> > > Hello,
> > > 
> > > I recently tried to burn some datas on CDs and DVD using a SATA burner
> > > and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> > > the device by sending SCSI commands over the 'sg' driver)
> > > 
> > 
> > Please note that the sg interface is depreciated.  It is now recommended 
> > that you send the CCBs directly to the normal device, i.e. /dev/hdc.
> 
> Of course for native IDE devices, we are using the /dev/hdXX device, but
> for SATA devices controlled by the libata, this is not possible ;)

for those there is /dev/scd0 etc...

(usually nicely symlinked to /dev/cdrom)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

