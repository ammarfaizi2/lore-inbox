Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSEASEU>; Wed, 1 May 2002 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313790AbSEASEU>; Wed, 1 May 2002 14:04:20 -0400
Received: from gherkin.frus.com ([192.158.254.49]:6784 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S313773AbSEASES>;
	Wed, 1 May 2002 14:04:18 -0400
Message-Id: <m172ySZ-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
In-Reply-To: <3CD02C60.3030004@wanadoo.fr> "from Pierre Rousselet at May 1, 2002
 07:56:48 pm"
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Date: Wed, 1 May 2002 13:04:11 -0500 (CDT)
CC: system_lists@nullzone.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> Bob_Tracy wrote:
> > Confirmed on a 2.5.11 system as well.  Talk about your basic heart
> > attack!  I'd just installed Postfix and found that I couldn't access
> > any of the directories under /var/spool/postfix.  Fortunately (?),
> > I've got older kernels to fall back on, and that's one of the hazards
> > of running on the bleeding edge I reckon.
> > 
> > Oh yeah...  ext2 filesystem.  I think this bug is at least mostly
> > independent of the filesystem type.
> 
> The same here with 2.5.12 and ext2, have you run fsck on this  fs ?

Yes, it's clean.  Changing the owner of the inaccessible directory to
root allows you to "cd" into it and everything seems normal.
Alternatively, you can simply boot up on an older kernel and that takes
care of the problem too.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
