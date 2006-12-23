Return-Path: <linux-kernel-owner+w=401wt.eu-S1752104AbWLWD00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWLWD00 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 22:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWLWD00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 22:26:26 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:47362 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751176AbWLWD0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 22:26:25 -0500
Message-ID: <458CA1DE.70804@scientia.net>
Date: Sat, 23 Dec 2006 04:26:22 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: John A Chaves <chaves@computer.org>
CC: Karsten Weiss <K.Weiss@science-computing.de>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>, muli@il.ibm.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de> <458C8EBE.3010506@scientia.net> <200612222056.39939.chaves@computer.org>
In-Reply-To: <200612222056.39939.chaves@computer.org>
Content-Type: multipart/mixed;
 boundary="------------030004010701000009000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030004010701000009000902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

John A Chaves wrote:
> I didn't need to run a specific test for this.  The normal workload of the
> machine approximates a continuous selftest for almost the last year.
>
> Large files (4-12GB is typical) are being continuously packed and unpacked
> with gzip and bzip2.  Statistical analysis of the datasets is followed by
> verification of the data, sometimes using diff, or md5sum, or python
> scripts using numarray to mmap 2GB chunks at a time.  The machine
> often goes for days with a load level of 20+ and 32GB RAM + another 32GB
> swap in use.  It would be very unlikely for data corruption to go unnoticed.
>
> When I first got the machine I did have some problems with disks being
> dropped from the RAID and occasional log messages implicating the IOMMU.
> But that was with kernel 2.6.16.?, Kernels since 2.6.17 haven't had any
> problem.
>   
Ah thanks for that info,.. as far as I can tell,.. this "testing
environment" should have found any corruptions I there had been any.

So I think we could take this as our first working system where the
issue don't occur although we would expect it...

Chris.

--------------030004010701000009000902
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030004010701000009000902--
