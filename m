Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSABJvN>; Wed, 2 Jan 2002 04:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSABJvC>; Wed, 2 Jan 2002 04:51:02 -0500
Received: from sun.fadata.bg ([80.72.64.67]:32529 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S286871AbSABJup>;
	Wed, 2 Jan 2002 04:50:45 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] mesh: target 0 aborted
In-Reply-To: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102091710.14178@smtp.noos.fr>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020102091710.14178@smtp.noos.fr>
Date: 02 Jan 2002 11:49:56 +0200
Message-ID: <87g05pytdn.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>>> This patch makes mesh.c compile, by adapting it to the new
>>> pmac_feature API (ported from the ppc tree).
>>> 
>>> In addition it contains the fix from Thomas Capricelli for the
>>> infamous "mesh: target 0 aborted" error, which I've been personally
>>> observing since 2.1.13x.
>> 
>> Er, what exactly is this against?  If this is just what's in the
>> linuxppc_2_4 tree against current 2.4.18pre, this is either (or will be
>> now :)) on BenH's list of things to resend to Marcelo, or there's a
>> problem with it still.  If you added in another patch, please re-send
>> this vs the linuxppc_2_4 tree.

Benjamin> The up to date mesh driver didn't get into 2.4.18pre1, either I forgot
Benjamin> to send it to Marcelo along with the other PPC patches, or he missed it.

Benjamin> I'll take care of this.

Benjamin> The other patch for getting rid of "target 0 aborted" need some more
Benjamin> review. You seem to just remove the bus reset. That could be made a
Benjamin> driver option in case it really cause trouble, but I suppose the bug
Benjamin> is elsewhere (while beeing triggered by the bus reset).

Benjamin> I'll look into this around next week.

Thanks a lot.

Regards,
-velco
