Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131928AbQKXGPl>; Fri, 24 Nov 2000 01:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131156AbQKXGPb>; Fri, 24 Nov 2000 01:15:31 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:48901 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S131928AbQKXGPS>; Fri, 24 Nov 2000 01:15:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andries.Brouwer@cwi.nl
Date: Fri, 24 Nov 2000 16:44:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14878.58.908955.701821@notabene.cse.unsw.edu.au>
Cc: greg@linuxpower.cx, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: message from Andries.Brouwer@cwi.nl on Friday November 24
In-Reply-To: <UTC200011240520.GAA143373.aeb@aak.cwi.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 24, Andries.Brouwer@cwi.nl wrote:
> >> ... RedHat's GCC snapshot "2.96" handles this case just fine.
> 
> > Now, if you can isolate the relevant part of the diff between
> > 2.95.2 and RH 2.96...
> 
> Maybe I have to be more precise in the statement "gcc 2.95.2 is buggy".
> 
> I just installed gcc 2.95.2 freshly ftp'ed from ftp.gnu.org, and
> 
...
> 
> So, not all versions of gcc 2.95.2 are equal.
> 
> % rpm -qf /usr/bin/gcc
> gcc-2.95.2-51
> 
> This is from a SuSE distribution, I forget which, not very recent.
> Revised summary: gcc-2.95.2-51 from SuSE is buggy.

Ditto for gcc-2.95.2-13 from Debian (potato). It exhibits the same
bug.
Debian applies a total of 49 patches to gcc and the libraries.

I am tempted to write a little script which discards the patches one
by one and re-builds and re-tests each time, and leave it going all
night.... but I'm not sure if I actually will.

NeilBrown


> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
