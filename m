Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRLDCir>; Mon, 3 Dec 2001 21:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284575AbRLCXvU>; Mon, 3 Dec 2001 18:51:20 -0500
Received: from [213.98.126.44] ([213.98.126.44]:914 "HELO mitica.trasno.org")
	by vger.kernel.org with SMTP id <S284621AbRLCOke>;
	Mon, 3 Dec 2001 09:40:34 -0500
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Christoph Hellwig <hch@caldera.de>, kdb@oss.sgi.com,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: Announce: kdb v1.9 is available for kernel 2.4.16
In-Reply-To: <5112.1007368812@ocs3.intra.ocs.com.au>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <5112.1007368812@ocs3.intra.ocs.com.au>
Date: 03 Dec 2001 15:38:50 +0100
Message-ID: <m2g06s5pxh.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "keith" == Keith Owens <kaos@melbourne.sgi.com> writes:

keith> On Mon, 3 Dec 2001 08:43:10 +0100, 
keith> Christoph Hellwig <hch@caldera.de> wrote:
>> On Mon, Dec 03, 2001 at 05:11:31PM +1100, Keith Owens wrote:
>>> This will probably be the last release of kdb using this patch format.
>>> I plan to split kdb into a core patch and smaller arch dependent
>>> patches, instead of one big patch for each arch.
>> 
>> Why can't you release one kdb patch instead?

keith> Because every architecture except i386 differes from the base kernel.
keith> IA64 has its own large patch set that has to be applied to the main
keith> kernel before kdb can be applied.  Sparc uses the vger kernel tree.
keith> The -ac trees are different again.

That is bad, now that you are able to create a kernel that will
compile in i386 & ia64 with latest ia64 patch, I will also like to
be able to integrate kdb there with support for both archs.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
