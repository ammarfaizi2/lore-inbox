Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRCLJTj>; Mon, 12 Mar 2001 04:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129284AbRCLJT3>; Mon, 12 Mar 2001 04:19:29 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:59145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129268AbRCLJTO>;
	Mon, 12 Mar 2001 04:19:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        elenstev@mesatop.com, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Rename all derived CONFIG variables 
In-Reply-To: Your message of "Mon, 12 Mar 2001 03:53:07 CDT."
             <20010312035307.A15136@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 20:18:24 +1100
Message-ID: <24972.984388704@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001 03:53:07 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>But if we're going to push Linus and the kernel crew to switch to
>CML2, then why invite the political tsuris of trying to get a large
>patch into 2.4 now?  Maybe I'm missing something here, but this doesn't
>seem necessary to me.

The derived config variables should be in a separate name space,
whether config is CML1 or CML2.  This patch does it for CML1.

