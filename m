Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278615AbRJXQDn>; Wed, 24 Oct 2001 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278635AbRJXQDY>; Wed, 24 Oct 2001 12:03:24 -0400
Received: from etna.trivadis.com ([193.73.126.2]:55029 "EHLO lttit")
	by vger.kernel.org with ESMTP id <S278615AbRJXQDT>;
	Wed, 24 Oct 2001 12:03:19 -0400
Date: Wed, 24 Oct 2001 18:00:39 +0200
From: Tim Tassonis <timtas@dplanet.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <E15wQTJ-0001v1-00@the-village.bc.nu>
In-Reply-To: <E15wQDj-0000HT-00@lttit>
	<E15wQTJ-0001v1-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.3cvs10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15wQSN-0000Hg-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 17:01:37 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> glibc 2.1.x has minimal support for 64bit file size handling. You
probably
> need to build 64bit aware tools. You might also be hitting a device bug
that
> seems to be in Linus kernel where devices are inheriting the file size
limit
> of the underlying fs the /dev node is on. However I thought that was
long
> fixed.
> 

The latter seems to be the case because Vita Samel (hope I got this right)
just reported that "Booting into 2.4.10-ac10" fixed the problem. Perhaps
it once was fixed and later defixed?

Bye
Tim


