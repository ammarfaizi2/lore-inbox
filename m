Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRAWQSU>; Tue, 23 Jan 2001 11:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbRAWQSJ>; Tue, 23 Jan 2001 11:18:09 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:14144 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129953AbRAWQSE>; Tue, 23 Jan 2001 11:18:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14957.44505.115108.445550@somanetworks.com>
Date: Tue, 23 Jan 2001 11:14:17 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Mike Harrold <mharrold@cas.org>
Cc: jearle@nortelnetworks.com (Jonathan Earle),
        linux-kernel@vger.kernel.org (Linux Kernel List)
Subject: Re: [OT?] Coding Style
In-Reply-To: <200101231600.LAA24562@mah21awu.cas.org>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com>
	<200101231600.LAA24562@mah21awu.cas.org>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MH" == Mike Harrold <mharrold@cas.org> writes:

 MH> For exactly the reverse of that reason. Typing capital letters is
 MH> a heck of a lot more difficult that addint an underscore.

 MH> Then there is reasability.

 MH> void ThisIsMyDumbassFunctionName

 MH> if MUCH more difficult to read than

 MH> void this_is_my_clear_and_easy_function_name

I think that the distinction is moot and this argument a waste of
time.  If you are anything more than a code tourist, you should have
no trouble dealing with mnemonic names.  So the above can become:

/*
 * timcaefn == this is my clear and easy function name
 */
void timcaefn (void);

If you're at all concerned about RSI, your fingers will thank you.

:-) :-) :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
