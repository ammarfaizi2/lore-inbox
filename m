Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLDRgQ>; Tue, 4 Dec 2001 12:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLDRej>; Tue, 4 Dec 2001 12:34:39 -0500
Received: from t2.redhat.com ([199.183.24.243]:63726 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281157AbRLDRQB>; Tue, 4 Dec 2001 12:16:01 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011204120612.B16578@thyrsus.com> 
In-Reply-To: <20011204120612.B16578@thyrsus.com>  <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <19642.1007484062@redhat.com> <3C0CFF5F.3090404@dplanet.ch> 
To: esr@thyrsus.com
Cc: Giacomo Catenazzi <cate@dplanet.ch>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 17:15:55 +0000
Message-ID: <23558.1007486155@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  No, it's CONFIG_EXPERT.  And this change is not wired in.  Comment
> out this declaration in the top-level rulesfile: 

> condition nohelp on EXPERT

> and it reverts to old behavior.

Good. Please make that the default when submitting the first version of 
CML2. You can submit patches which effect the change in behaviour later, 
and they can be individually considered. 


--
dwmw2


