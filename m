Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290588AbSAYH2s>; Fri, 25 Jan 2002 02:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290586AbSAYH2j>; Fri, 25 Jan 2002 02:28:39 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:32168 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S290589AbSAYH2X>; Fri, 25 Jan 2002 02:28:23 -0500
Message-Id: <200201250728.g0P7SDH26738@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Fri, 25 Jan 2002 08:28:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201240858.g0O8wnH03603@bliss.uni-koblenz.de> <20020124121649.A7722@devserv.devel.redhat.com>
In-Reply-To: <20020124121649.A7722@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
>
> Rainer, you missed the point. Nobody cares about small things
> such as "cannot start nfsd" while your 4096 mounts patch
> simply CORRUPTS YOUR DATA TO HELL.
>

Well I never said, I really knew what I was doing:-).  Thats exacly why I 
asked about why to use more major devices? OK the anser to this question 
seems to be that minor devices may only be 8 bit due to the static nature of 
some kernel structures. Right?

> If you need more than 1200 mounts, you have to add more majors
> to my patch. There is a number of them between 115 and 198.
> I suspect scalability problems may become evident
> with this approach, but it will work.

The solution Richard posted seems to be interesting at this point isn't it?

Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
