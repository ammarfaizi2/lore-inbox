Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVAFR7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVAFR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbVAFR6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:58:34 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:54363 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262962AbVAFRzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:55:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SdKx7tD0ijgqQKtFaZYaspU2iW/S3nBCnOLqyllukdbNDPFtkqT4Tu4WlmFpcBhIzMtFoVd2DxdWBEfcp2qc0WsPWLQ/b9tRTXzYw0cwlxAJE4YgYLKk5d0wA5dbP9E0WsXyzVjJ+YRqpdqCC7ZAtfSw1AJC1AMAygZMoP4Gf1A=
Date: Thu, 6 Jan 2005 18:55:29 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-Id: <20050106185529.43662ebc.diegocg@gmail.com>
In-Reply-To: <200501061811.51659@zodiac.zodiac.dnsalias.org>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<200501061811.51659@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 6 Jan 2005 18:11:51 +0100 Alexander Gran <alex@zodiac.dnsalias.org> escribió:


> Y stays black, I need sysrq to reboot. mm1 works fine.
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
> 03)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
> [Radeon Mobility 9000 M9] (rev 02)


I was going to report that bug, too. Mine is a p3 with:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)

and using x.org
