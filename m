Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282300AbRKXAO7>; Fri, 23 Nov 2001 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282301AbRKXAOs>; Fri, 23 Nov 2001 19:14:48 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:59921 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282300AbRKXAOg>;
	Fri, 23 Nov 2001 19:14:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: viro@math.psu.edu
Date: Sat, 24 Nov 2001 01:13:55 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [false alarm] Re: 2.5.0 breakage even with fix?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A0AC5B46636@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 01 at 1:05, Petr Vandrovec wrote:
> do not have coherent /dev/hda3 cache, I have no idea how to read
> real contents of /var/lib/dpkg/tmp.ci, but
> ls -l /var/lib/dpkg/tmp.ci/ reemited error message about
> ext2-fs error, so I think that it is real problem, and my tmp.ci directory
> contains some file contents instead. And I'm 100% sure that
> /var/lib/dpkg/tmp.ci was created with patched kernel :-(

I deeply apologize. I added one '!' into patch by mistake, so
my 'patched' kernel released inodes on MS_ACTIVE systems back
as free :-(
                                Sorry for confusion,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
