Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbREFLln>; Sun, 6 May 2001 07:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135632AbREFLle>; Sun, 6 May 2001 07:41:34 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:56080 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135626AbREFLlZ>; Sun, 6 May 2001 07:41:25 -0400
Date: Sun, 6 May 2001 23:41:23 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 connecting with mac os 8.3
Message-ID: <20010506234123.C32060@metastasis.f00f.org>
In-Reply-To: <01C0D62C.02EC0060.folkert@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01C0D62C.02EC0060.folkert@vanheusden.com>; from folkert@vanheusden.com on Sun, May 06, 2001 at 12:56:46PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 12:56:46PM +0200, Folkert van Heusden wrote:

    Anyone out there who cares if 2.4.3 has problems connectin with
    mac os 8.x?  Situation: pop3-server on linux 2.4.3 host. Client:
    eudora on mac os 8.x connection times out.  always 2.4.4 works
    fine(!).  Any more investigation required?

Can you produce a tcpdump of this timeout? Something like:

	tcpdump -ln port pop3

on the linux box (as root) should do.


  --cw

