Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284375AbRLCIvw>; Mon, 3 Dec 2001 03:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284356AbRLCIt1>; Mon, 3 Dec 2001 03:49:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36881 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284905AbRLCIk1>;
	Mon, 3 Dec 2001 03:40:27 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: Announce: kdb v1.9 is available for kernel 2.4.16 
In-Reply-To: Your message of "Mon, 03 Dec 2001 08:43:10 BST."
             <20011203084310.A11737@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Dec 2001 19:40:12 +1100
Message-ID: <5112.1007368812@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001 08:43:10 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>On Mon, Dec 03, 2001 at 05:11:31PM +1100, Keith Owens wrote:
>> This will probably be the last release of kdb using this patch format.
>> I plan to split kdb into a core patch and smaller arch dependent
>> patches, instead of one big patch for each arch.
>
>Why can't you release one kdb patch instead?

Because every architecture except i386 differes from the base kernel.
IA64 has its own large patch set that has to be applied to the main
kernel before kdb can be applied.  Sparc uses the vger kernel tree.
The -ac trees are different again.

