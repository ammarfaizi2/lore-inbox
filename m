Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263338AbREXBtC>; Wed, 23 May 2001 21:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbREXBsx>; Wed, 23 May 2001 21:48:53 -0400
Received: from attila.bofh.it ([213.92.8.2]:22223 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S263338AbREXBsr>;
	Wed, 23 May 2001 21:48:47 -0400
Date: Thu, 24 May 2001 03:48:24 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010524034824.C26674@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010521184758.B24682@redhat.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, "Stephen C. Tweedie" <sct@redhat.com> wrote:

 >Just set chattr +S on the spool dir.  That's what the flag is for.
 >The biggest problem with that is that it propagates to subdirectories
 >and files --- would a version of the flag which applied only to
 >directories be a help here?
Yes, please. It's what is really needed by MTA (not only for spool, but
for maildir delivery too).

-- 
ciao,
Marco
