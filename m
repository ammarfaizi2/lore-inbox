Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136667AbREARL3>; Tue, 1 May 2001 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136665AbREARLT>; Tue, 1 May 2001 13:11:19 -0400
Received: from pyongsan.compgen.com ([158.155.0.1]:3091 "EHLO
	panmunjom.compgen.com") by vger.kernel.org with ESMTP
	id <S136664AbREARLJ>; Tue, 1 May 2001 13:11:09 -0400
From: "Eric Z. Ayers" <Eric.Ayers@intec-telecom-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15086.60620.745722.345084@gargle.gargle.HOWL>
Date: Tue, 1 May 2001 13:05:16 -0400 (EDT)
To: Doug Ledford <dledford@redhat.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <3AEEDFFC.409D8271@redhat.com>
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
	<3AEEDFFC.409D8271@redhat.com>
X-Mailer: VM 6.72 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Reply-To: Eric.Ayers@intec-telecom-systems.com
X-Face: (3Y\Z;G!Ce[Q\WBgGFLgcaL%v[kJ'@9s`Qn1<)EEL5tSW7IDvX[{APQ5]eY}uF}%qbD[-@N
 !5]S!%o0*DbAB?~o%tca^?3@zU~"fQ@MTiClP>w%`Y8oG&6|:>2F=bhnf2>bPedqw-.T>U-BaI`F>1
 QY@?oGJ0.lV?b@0HgvaOt>=0,/@,=(kE"J++vO?K"3ve@,"sunF0HnU|h&|:}%|P6%BohO_*mAHJ#g
 EHc;_'bXG|kCLMSF`:/O_F0fuJ:j2^C\NJ(:$izN@mbXQo(IL,<P@2U+(Z`@>BO.7<]wT?:5.A<$C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford writes:
(James Bottomley commented about the need for SCSI reservation kernel patches)
 > 
 > I agree.  It's something that needs fixed in general, your software needs it
 > as well, and I've written (about 80% done at this point) some open source
 > software geared towards getting/holding reservations that also requires the
 > same kernel patches (plus one more to be fully functional, an ioctl to allow a
 > SCSI reservation to do a forced reboot of a machine).  I'll be releasing that
 > package in the short term (once I get back from my vacation anyway).
 > 

Hello Doug,

Does this package also tell the kernel to "re-establish" a
reservation for all devices after a bus reset, or at least inform a
user level program?  Finding out when there has been a bus reset has
been a stumbling block for me.

-Eric.
--
Eric Z. Ayers				              Lead Software Engineer
Phone:  +1 404-705-2864                    Computer Generation, Incorporated
Fax:    +1 404-705-2805                     an Intec Telecom Systems Company
Web:    http://www.intec-telecom-systems.com/
Email:  eric.ayers@intec-telecom-systems.com
Postal: Bldg G 4th Floor, 5775 Peachtree-Dunwoody Rd, Atlanta, GA 30342 USA
