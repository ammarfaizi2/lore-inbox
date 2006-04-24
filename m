Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWDXQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWDXQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWDXQ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:27:28 -0400
Received: from mailgw3.ericsson.se ([193.180.251.60]:58525 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP
	id S1750742AbWDXQ11 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:27:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Date: Mon, 24 Apr 2006 12:27:21 -0400
Message-ID: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Thread-Index: AcZm0BC7bmD+ScgIT0m3SqBlsdD4qAA6tNCQ
From: "Makan Pourzandi \(QB/EMC\)" <makan.pourzandi@ericsson.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
       "Serue Hallyen" <serue@us.ibm.com>,
       "Axelle Apvrille" <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       <disec-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 24 Apr 2006 16:27:22.0495 (UTC) FILETIME=[F6DE58F0:01C667BB]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan, 

I hope I correctly understood your question, DigSig uses LSM hooks to
check the digital signature before loading it, then as long as your elf
loader uses kernel system calls, it's covered by DigSig. 

Regards 
Makan 


> -----Original Message-----
> From: linux-security-module-owner@vger.kernel.org 
> [mailto:linux-security-module-owner@vger.kernel.org] On 
> Behalf Of Arjan van de Ven
> Sent: April 23, 2006 8:19 AM
> To: Makan Pourzandi (QB/EMC)
> Cc: linux-kernel@vger.kernel.org; 
> linux-security-module@vger.kernel.org; Serue Hallyen; Axelle 
> Apvrille; 'disec-devel@lists.sourceforge.net'
> Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for 
> run-timeauthentication of binaries
> 
> On Fri, 2006-04-21 at 09:56 +0000, Makan Pourzandi wrote:
> > Hi,
> > 
> > Digsig development team would like to announce the release 
> 1.5 of digsig.
> > 
> > This kernel module helps system administrators control 
> Executable and 
> > Linkable Format (ELF) binary execution and library loading based on 
> > the presence of a valid digital signature.  The main 
> functionality is 
> > to help system administrators distinguish applications 
> he/she trusts 
> > (and therefore signs) from viruses, worms (and other 
> nuisances). It is 
> > based on the Linux Security Module hooks.
> 
> does this also prevent people writing their own elf loader in 
> a bit of perl and just mmap the code ?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-security-module" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
