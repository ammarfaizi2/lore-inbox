Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRHNIfU>; Tue, 14 Aug 2001 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270529AbRHNIfA>; Tue, 14 Aug 2001 04:35:00 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:19665 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S270528AbRHNIex> convert rfc822-to-8bit; Tue, 14 Aug 2001 04:34:53 -0400
Importance: Normal
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: Andrew Morton <akpm@zip.com.au>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
        "Carsten Otte" <COTTE@de.ibm.com>,
        Tom Rini <trini@kernel.crashing.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD45D76E6.BCB6AAFC-ONC1256AA8.002CB890@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Tue, 14 Aug 2001 10:34:35 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 14/08/2001 10:34:18
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> If it's possible, could you please also test journalled data mode?

I finished some tests with journalled data mode and with ordered mode. Both
modes seems to run correct, in the meaning of stability and correct log
replay, after a forced restart on S390 architecture, but further testing is
planned.

Today I started testing ext3 on an IBM zSeries  (s390x in the kernel tree).
It might be interesting for you, that s390x is a 64bit big endian machine.
I will post the results if I face any problems.

--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507





