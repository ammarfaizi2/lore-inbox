Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131124AbRAaBLg>; Tue, 30 Jan 2001 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132283AbRAaBL2>; Tue, 30 Jan 2001 20:11:28 -0500
Received: from palrel1.hp.com ([156.153.255.242]:60427 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S131124AbRAaBLL>;
	Tue, 30 Jan 2001 20:11:11 -0500
Message-ID: <3A77661C.5D7FD4C@cup.hp.com>
Date: Tue, 30 Jan 2001 17:10:52 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to 
 dowith ECN)
In-Reply-To: <Pine.GSO.4.30.0101301944181.3017-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ** I reported that there was also an oddity in throughput values,
> unfortunately since no one (other than me) seems to have access
> to a gige cards in the ZC list, nobody can confirm or disprove
> what i posted. Here again as a reminder:
> 
> Kernel     |  tput  | sender-CPU | receiver-CPU |
> -------------------------------------------------
> 2.4.0-pre3 | 99MB/s |   87%      |  23%         |
> NSF        |        |            |              |
> -------------------------------------------------
> 2.4.0-pre3 | 86MB/s |   100%     |  17%         |
> SF         |        |            |              |
> -------------------------------------------------
> 2.4.0-pre3 | 66.2   |   60%      |  11%         |
> +ZC        | MB/s   |            |              |
> -------------------------------------------------
> 2.4.0-pre3 | 68     |   8%       |  8%          |
> +ZC  SF    | MB/s   |            |              |
> -------------------------------------------------
> 
> Just ignore the CPU readings, focus on throughput. And could someone plese
> post results?

In the spirit of the socratic method :)

Is your gige card based on Alteon?

How does ZC/SG change the nature of the packets presented to the NIC?

How well does the NIC do with that changed nature?

rick jones

sometimes, performance tuning is like squeezing a balloon. one part gets
smaller, but then you start to see the rest of the balloon...

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
