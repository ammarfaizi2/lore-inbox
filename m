Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313902AbSDQU2a>; Wed, 17 Apr 2002 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313908AbSDQU23>; Wed, 17 Apr 2002 16:28:29 -0400
Received: from ns.suse.de ([213.95.15.193]:1286 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313902AbSDQU22>;
	Wed, 17 Apr 2002 16:28:28 -0400
Date: Wed, 17 Apr 2002 22:23:12 +0200
From: Dave Jones <davej@suse.de>
To: Robert Love <rml@tech9.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Message-ID: <20020417222312.J29982@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca> <1833210000.1019077852@flay> <1019074547.1670.98.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 04:15:42PM -0400, Robert Love wrote:
 > > > Total of 4 processors activated (14299.95 BogoMIPS).
 > Certainly not the mips*4 that bogomips is showing :)
 > I guess that is a "bug" ?

Well, it justifies a comment in arch/i386/kernel/smpboot.c

1181     /*
1182      * Allow the user to impress friends.
1183      */

8-)

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
