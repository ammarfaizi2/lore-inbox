Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUCEMqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUCEMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:46:24 -0500
Received: from gstserv.netnea.com ([213.200.225.210]:36723 "EHLO
	james.netnea.com") by vger.kernel.org with ESMTP id S262579AbUCEMqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:46:21 -0500
Date: Fri, 5 Mar 2004 13:46:08 +0100
From: Charles Bueche <charles@bueche.ch>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x
 and up
Message-Id: <20040305134608.115dfeed.charles@bueche.ch>
In-Reply-To: <4047756D.2050402@blue-labs.org>
References: <4047756D.2050402@blue-labs.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: $|Nk/@TgZ5o#.yMqN*6c'4p/618&z3u~2V8.*td7vyVp9lPIy!O@{.bF+/o["H-00Fxfh3E|X"G|[K7y(aN\\BZ^'J#\"1u2&Qbe'8l<{3qBqy|R/_s_8o5fVUjg@dZ'E\tf_u^{;{g%*/6Glu!-~D\#,Gw_TD&p'mURwR2AnKX"!FSB#b&CD`0\ZEp52#W-z`Z~b2lPwv~de]a01M[&e+SwzgeIwtGaPp@@6pK=4?a0d9rVYnGs(Cf
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have had this problem (or at least very similar) since 2.6.0. the
-test worked fine.

I run 2.6.3-gentoo-r1 on a Dell Inspiron 8600

Charles

On Thu, 04 Mar 2004 13:29:01 -0500
David Ford <david+challenge-response@blue-labs.org> wrote:

> powerix root # cat /proc/acpi/battery/BAT0/state
> present:                 yes
> ERROR: Unable to read battery status
> 
> powerix root # dmesg -c
>     ACPI-0279: *** Error: Looking up [BST0] in namespace,
>     AE_ALREADY_EXISTS ACPI-1120: *** Error: Method execution failed
>     [\_SB_.BAT0._BST] 
> (Node e7bd7680), AE_ALREADY_EXISTS
> 
> powerix root # uname -r
> 2.6.4-rc1
> 
> This has been going on since about 2.6.3-rc something.  Some while
> after reading the /proc files, the ability to read the battery
> information gets munged.
