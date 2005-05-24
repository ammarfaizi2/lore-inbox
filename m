Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVEXAgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEXAgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVEXAgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:36:14 -0400
Received: from pat.uio.no ([129.240.130.16]:63882 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261246AbVEXAfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:35:23 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116888428.5206.14.camel@tiger>
References: <1116888428.5206.14.camel@tiger>
Content-Type: multipart/mixed; boundary="=-Ws8ieE2i66KCbVxCY/dF"
Date: Mon, 23 May 2005 20:35:17 -0400
Message-Id: <1116894917.11483.111.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.817, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ws8ieE2i66KCbVxCY/dF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ty den 24.05.2005 Klokka 00:47 (+0200) skreiv Kenneth Johansson:
> I have both the server and client running  2.6.11.7 and have some severe
> data corruption when reading from the server (maybe on write also I have
> not tested).
> 
> If I copy the data over with scp or ftp I get correct data. Also  nfs
> works OK with a mac os x 10.4 client.
> 
> Running gen.sh on the server and then cmp.sh on the client results in a
> md5 checksum difference on 5-12 files I have never done one run where
> there was no errors. 
> 
> This is what cat /proc/mounts reports on the nfs mount
> 
> :/export/home/ken /home/ken nfs rw,v3,rsize=32768,wsize=32768,hard,udp,lock,addr=amd 0 0
> 

I'm seeing no problems at all with this on a loopback mount with
2.6.12-rc4. Mind giving us some more details on your setup?

Cheers,
  Trond

--=-Ws8ieE2i66KCbVxCY/dF
Content-Disposition: attachment; filename=sum_org
Content-Type: text/plain; name=sum_org; charset=UTF-8
Content-Transfer-Encoding: 7bit

9e068cf97d3382d033e9fd2ad811b6a3  0
79b40e24ed13f1c16007e844d8fe9d93  1
4f3abe3f5e6de2e9e59454de1a768a9f  2
dfe58bae3169382d47ab018565cd2cc9  3
56135ada6249175b1f78e596ecbfd859  4
441156cb860423f4903b01353dcd986e  5
b5b2ffbcfb0902476fa67139238a66c4  6
8c5cd6943b9f02fa752b9ee5faeb30d2  7
ee8428a730822171053970b461bd5c27  8
78e4a42024075801df90e2adc4c314aa  9
d5c48cc0007a212f27621b180195f061  10
ab610700befe732d8abbf23de41b2f0d  11
af6c2a4372a7537725d8245cada83b72  12
9ec40dbfeeac74e69ecd7d16c3e6bcb1  13
542e624e404b1c277db7190288028201  14
7be4bd273006e5f535a365f917e9cb88  15
75a61da2dbd52484d091e9abc594eca7  16
4b9a14953134873e718b9251a573a0c2  17
40b04c291ae3843aec667cb1c90d50e6  18
c96e00d3ce1cb0a690f9cf51e42aa21f  19
8231093f537ad37fc1825de7ae7d1623  20
2051e8708251d0e32b4078882303e1d1  21
1878e49986ebbc1c3fedf3fc253f8949  22
81a10eb96087cdf75cb1250daa54c033  23
b0eade848db80c36f567a3994214868f  24
4f09df57a60e4de43e662a535a131b7a  25
a5b0991219a0d6ef5d1aaec5dc95d28a  26
c3bc7156aca526b81ade9bf6ddc991bf  27
b0794f598cfd8a5e61a741453c2c0142  28
dccff34e9b630fd575faefe4bd3f4a29  29

--=-Ws8ieE2i66KCbVxCY/dF
Content-Disposition: attachment; filename=sum_new
Content-Type: text/plain; name=sum_new; charset=UTF-8
Content-Transfer-Encoding: 7bit

9e068cf97d3382d033e9fd2ad811b6a3  0
79b40e24ed13f1c16007e844d8fe9d93  1
4f3abe3f5e6de2e9e59454de1a768a9f  2
dfe58bae3169382d47ab018565cd2cc9  3
56135ada6249175b1f78e596ecbfd859  4
441156cb860423f4903b01353dcd986e  5
b5b2ffbcfb0902476fa67139238a66c4  6
8c5cd6943b9f02fa752b9ee5faeb30d2  7
ee8428a730822171053970b461bd5c27  8
78e4a42024075801df90e2adc4c314aa  9
d5c48cc0007a212f27621b180195f061  10
ab610700befe732d8abbf23de41b2f0d  11
af6c2a4372a7537725d8245cada83b72  12
9ec40dbfeeac74e69ecd7d16c3e6bcb1  13
542e624e404b1c277db7190288028201  14
7be4bd273006e5f535a365f917e9cb88  15
75a61da2dbd52484d091e9abc594eca7  16
4b9a14953134873e718b9251a573a0c2  17
40b04c291ae3843aec667cb1c90d50e6  18
c96e00d3ce1cb0a690f9cf51e42aa21f  19
8231093f537ad37fc1825de7ae7d1623  20
2051e8708251d0e32b4078882303e1d1  21
1878e49986ebbc1c3fedf3fc253f8949  22
81a10eb96087cdf75cb1250daa54c033  23
b0eade848db80c36f567a3994214868f  24
4f09df57a60e4de43e662a535a131b7a  25
a5b0991219a0d6ef5d1aaec5dc95d28a  26
c3bc7156aca526b81ade9bf6ddc991bf  27
b0794f598cfd8a5e61a741453c2c0142  28
dccff34e9b630fd575faefe4bd3f4a29  29

--=-Ws8ieE2i66KCbVxCY/dF--

