Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbRA0E7y>; Fri, 26 Jan 2001 23:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRA0E7p>; Fri, 26 Jan 2001 23:59:45 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:7177 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S130679AbRA0E7c>; Fri, 26 Jan 2001 23:59:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<14960.56461.296642.488513@pizda.ninka.net>
	<3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no>
	<94tho8$627$1@abraham.cs.berkeley.edu>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 27 Jan 2001 15:59:25 +1100
In-Reply-To: daw@mozart.cs.berkeley.edu's message of "27 Jan 01 04:10:48 GMT"
Message-ID: <84zogdtwsy.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Wagner <daw@mozart.cs.berkeley.edu> writes:

    David> Practice being really, really paranoid.  Think: You're
    David> designing a firewall; you've got some reserved bits,
    David> currently unused; any future code that uses them could
    David> behave in completely arbitrary and insecure ways, for all
    David> you know.  Now recall that anything not known to be safe
    David> should be denied (in a good firewall) -- see Cheswick and
    David> Bellovin for why.  When you take this point of view, it is
    David> completely understandable why firewalls designed before ECN
    David> was introduced might block it.

In which case, people who use these firewall products need to realize
that future developments may break these assumptions, and that the
firewall software needs to be updated/reconfigured as a result.
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
