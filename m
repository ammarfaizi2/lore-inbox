Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbTJOOtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTJOOtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 10:49:03 -0400
Received: from mail.midmaine.com ([66.252.32.202]:32951 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S263346AbTJOOs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 10:48:57 -0400
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
X-Eric-Conspiracy: There Is No Conspiracy
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl>
From: Erik Bourget <erik@midmaine.com>
Date: Wed, 15 Oct 2003 10:47:42 -0400
In-Reply-To: <20031015142738.GG24799@bitwizard.nl> (Erik Mouw's message of
 "Wed, 15 Oct 2003 16:27:38 +0200")
Message-ID: <87wub6o8vl.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
>> Erik Mouw writes:
>>  > Nowadays disks are so incredibly cheap, that transparent compression
>>  > support is not realy worth it anymore (IMHO).
>> 
>> But disk bandwidth is so incredibly expensive that compression becoming
>> more and more useful: on compressed file system bandwidth of user-data
>> transfers can be larger than raw disk bandwidth. It is the same
>> situation as with allocation of disk space for files: disks are cheap,
>> but storing several files in the same block becomes more advantageous
>> over time.
>
> You have a point, but remember that modern IDE drives can do about
> 50MB/s from medium. I don't think you'll find a CPU that is able to
> handle transparent decompression on the fly at 50MB/s, even not with a
> simple compression scheme as used in NTFS (see the NTFS docs on
> SourceForge for details).
>
> Erik
>
> PS: let me guess: among other things, reiser4 comes with transparent
>     compression? ;-)

Reiser4 made my coffee this morning, it's wonderful :)

Seriously, though, (and getting off the topic), has anyone started to use
reiser4 in a high-load environment?  I've got a mail system that shoots a few
million messages through it every day and a filesystem that's faster with
creating and deleting tons of ~4kb qmail queue files (with data journaling!)
would be verrry innnteresting.

- Erik Bourget

