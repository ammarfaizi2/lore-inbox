Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313910AbSDPVGs>; Tue, 16 Apr 2002 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDPVGr>; Tue, 16 Apr 2002 17:06:47 -0400
Received: from ns.suse.de ([213.95.15.193]:20499 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313910AbSDPVGr>;
	Tue, 16 Apr 2002 17:06:47 -0400
Date: Tue, 16 Apr 2002 23:06:45 +0200
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
Message-ID: <20020416230645.D32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m1r8lfigqc.fsf@frodo.biederman.org> <200204162051.g3GKpDb05800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 03:51:12PM -0500, James Bottomley wrote:
 > I agree with both of these.  The main problem with the memory setup calls is 
 > that most of them are static.  I could export them and do overrides, like I do 
 > for everything else, but as someone who also debugs the kernel, I like static 
 > functions because they tell me the use is tightly isolated.  I could easily do 
 > two files, it was just looking more messy.
 > 
 > I'll see if I can export some of the setup.c internals and re-arrange this in 
 > a more orderly way.

I think this is where Patrick Mochel's recent work in that area is going to 
come in handy. setup.c has been nicely abstracted out into seperate
parts, that should make things a little easier.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
