Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbREFC1J>; Sat, 5 May 2001 22:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbREFC1B>; Sat, 5 May 2001 22:27:01 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:49936 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131386AbREFCZv>; Sat, 5 May 2001 22:25:51 -0400
Date: Sun, 6 May 2001 14:25:48 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Peter Rival <frival@zk3.dec.com>, Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010506142548.D31269@metastasis.f00f.org>
In-Reply-To: <20010506033746.A30690@metastasis.f00f.org> <Pine.LNX.4.21.0105052317080.582-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105052317080.582-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 05, 2001 at 11:19:09PM -0300
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 11:19:09PM -0300, Rik van Riel wrote:

    This only leaves two issues, the first is device drivers and the
    second is the question whether we'd want the overhead needed to
    implement the (fairly easy) memory relocation.

How do you relocate

  -- pages which are mlocked without violating RT contraints?

  -- pages which contain kernel pointers and might be accessed from
     interrupt context?



  --cw
