Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131425AbRAJRMu>; Wed, 10 Jan 2001 12:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131611AbRAJRMk>; Wed, 10 Jan 2001 12:12:40 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:24308 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S131425AbRAJRMc>;
	Wed, 10 Jan 2001 12:12:32 -0500
Date: Wed, 10 Jan 2001 18:11:46 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Stefan Traby <stefan@hello-penguin.com>
Cc: "Vladimir V. Saveliev" <vs@namesys.botik.ru>, Chris Mason <mason@suse.com>,
        Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010110181146.A2303@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <75150000.979093424@tiny> <3A5C8780.5B02EC8A@namesys.botik.ru> <20010110180353.B2101@stefan.sime.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110180353.B2101@stefan.sime.com>; from stefan@hello-penguin.com on Wed, Jan 10, 2001 at 06:03:53PM +0100
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 06:03:53PM +0100, Stefan Traby wrote:

> Really, the 255-limit is essential as long as "struct dirent/64" has
> d_name[255] hard coded. Somebody should send Drepper a patch;

sorry, d_name[256], not 255 in both, glibc and kernel...

-- 

    Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
