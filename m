Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXEkp>; Thu, 23 Nov 2000 23:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129632AbQKXEke>; Thu, 23 Nov 2000 23:40:34 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:5895
        "HELO metastasis.f00f.org") by vger.kernel.org with SMTP
        id <S129219AbQKXEkU>; Thu, 23 Nov 2000 23:40:20 -0500
Date: Fri, 24 Nov 2000 17:10:14 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc 2.95.2 is buggy
Message-ID: <20001124171014.A26050@metastasis.f00f.org>
In-Reply-To: <UTC200011240157.CAA140709.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011240157.CAA140709.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Nov 24, 2000 at 02:57:45AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 02:57:45AM +0100, Andries.Brouwer@cwi.nl wrote:

    /*
     * bug.c - aeb, 001124
     *
     * This program shows a bug in gcc 2.95.2.
     * It should print 0x0 and exit.
     * For me it prints 0x84800000.
     *
     * Compile with:
     *    gcc -Wall -O2 -o bug bug.c
     */

taking away -O2 is a 'fix' for now... not a very good one though.


  --cw


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
