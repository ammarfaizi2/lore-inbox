Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbRHFTNO>; Mon, 6 Aug 2001 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268942AbRHFTNE>; Mon, 6 Aug 2001 15:13:04 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:46340 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S268941AbRHFTMz>;
	Mon, 6 Aug 2001 15:12:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: haiquy@yahoo.com
Date: Mon, 6 Aug 2001 21:12:34 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.7-ac7 ext3: Can I remount and change mount option ?
CC: kernel <linux-kernel@vger.kernel.org>, akpm@zip.com.au
X-mailer: Pegasus Mail v3.40
Message-ID: <9FE3B5FC2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 01 at 12:07, Andrew Morton wrote:
> Steve Kieu wrote:
> > 
> > Hi,
> > 
> > I still can not remount my ext3 root partition to
> > change to the data=writeback mode using 2.4.7-ac7 .

Steve, you are probably looking for 'rootflags=data=writeback'
kernel commandline option. Just add this into your lilo.conf.
In /etc/fstab either do not specify 'data=writeback' at all for
root partition, or you must use 'data=writeback' (I prefer
specifying data=xxx, as then / and other partitions look same
in fstab).
                                Best regards,
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
