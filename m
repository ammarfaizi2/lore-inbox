Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277589AbRJHWxP>; Mon, 8 Oct 2001 18:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277577AbRJHWxG>; Mon, 8 Oct 2001 18:53:06 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:49083 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277588AbRJHWww>;
	Mon, 8 Oct 2001 18:52:52 -0400
Date: Mon, 08 Oct 2001 23:53:18 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <653073165.1002585197@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1011009001720.20446A-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011009001720.20446A-100000@artax.karlin.mff.cuni
 .cz>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, 09 October, 2001 12:21 AM +0200 Mikulas Patocka 
<mikulas@artax.karlin.mff.cuni.cz> wrote:

> If you have more than half of virtual space free, you can always find two
> consecutive free pages. Period.

Now calculate the probability of not being able to do this in physical
space, assuming even page dispersion, and many pages free. You will
find it is very small. This may give you a clue as to what the problem
actually is.

--
Alex Bligh
