Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136486AbREDShS>; Fri, 4 May 2001 14:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136488AbREDShH>; Fri, 4 May 2001 14:37:07 -0400
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:52158 "HELO
	mcafee-labs.nai.com") by vger.kernel.org with SMTP
	id <S136482AbREDSgO>; Fri, 4 May 2001 14:36:14 -0400
Message-ID: <XFMail.20010504113850.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3AF2F09C.C5731842@chromium.com>
Date: Fri, 04 May 2001 11:38:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Fabio Riccardi <fabio@chromium.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
Cc: David_J_Morse@Dell.com, "Timothy D. Witham" <wookie@osdlab.org>,
        Andrew Morton <andrewm@uow.edu.au>, Christopher Smith <x@xman.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-May-2001 Fabio Riccardi wrote:
> ok, I'm totally ignorant here, what is a pipelined request?



http://www.w3.org/Protocols/HTTP/Performance/Pipeline.html

<QUOTE>
A pipelined application implementation buffers its output before writing it to
the underlying TCP stack, roughly equivalent to what the Nagle algorithm does
for telnet connections.
These two buffering algorithms tend to interfere, and using them together will
often cause very significant performance degradation. For each connection, the
server maintains a
response buffer that it flushes either when full, or when there is no more
requests coming in on that connection, or before it goes idle. This buffering
enables aggregating responses
(for example, cache validation responses) into fewer packets even on a
high-speed network, and saving CPU time for the server. 
</QUOTE>





- Davide

