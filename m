Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUK1NSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUK1NSW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUK1NSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:18:22 -0500
Received: from neopsis.com ([213.239.204.14]:47527 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261464AbUK1NST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:18:19 -0500
Message-ID: <41A9D05A.6030302@dbservice.com>
Date: Sun, 28 Nov 2004 14:19:22 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <41A9CD78.1050002@dbservice.com> <20041128131159.GC26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041128131159.GC26051@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Nov 28, 2004 at 02:07:04PM +0100, Tomas Carnecky wrote:
> 
>>>Think read(2)/write(2).  We already have several barfbags too many,
>>>and that includes both ioctl() and setsockopt().  We are stuck with
>>>them for compatibility reasons, but why the hell would we need yet
>>>another one?
>>
>>And what's the option? So without ioctl, how would you reaplace this:
>>ioctl(cdrom_fd, CDROMEJECT, 0)?
> 
> Which part of "we are stuck with them" is not clear enough?  If you insist
> on using the same descriptor for data and for out-of-band mess - no, you
> can't get anything saner.  If you do not, you can; it's that simple...

Ok, I know ioctl is bad, but please tell me how to replace them, that's
all I want to know. Did you propose any other mechanism which could
replace ioctl? Or do you think such things (eject the cdrom) are not
meant to be done from applications?
I certainly don't insist on using them, but I don't see (yet) any way
how to replace them. Please enlighten me.

tom
