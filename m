Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311210AbSCLOSB>; Tue, 12 Mar 2002 09:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCLORv>; Tue, 12 Mar 2002 09:17:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311210AbSCLORj>;
	Tue, 12 Mar 2002 09:17:39 -0500
Date: Tue, 12 Mar 2002 14:17:38 +0000
From: wli@holomorphy.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andrea Arcangeli <andrea@suse.de>, wli@parcelfarce.linux.theplanet.co.uk,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312141738.D14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
In-Reply-To: <20020312135605.P25226@dualathlon.random> <Pine.LNX.3.95.1020312083126.14299A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020312083126.14299A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Mar 12, 2002 at 08:33:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 08:33:23AM -0500, Richard B. Johnson wrote:
> This is a simple random number generator. It takes a pointer to your
> own private long, somewhere in your code, and returns a long random
> number with a period of 0xfffd4011. I ran a program for about a
> year, trying to find a magic number that will produce a longer
> period.
> 
> You could add a ldiv and return the modulus to set hash-table limits.
> ANDs are not good because, in principle, you could get many numbers
> in which all the low bits are zero.
> 
> 
> The advantage of this simple code is it works quickly. The disadvantages
> are, of course, its not portable and a rotation of a binary number
> is not a mathematical function, lending itself to rigorous analysis.

Would you mind explaining what the point of this is? AFAICT this is
meaningless noise inspired by the words "/dev/random".


Bill
