Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSBDMcZ>; Mon, 4 Feb 2002 07:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSBDMcS>; Mon, 4 Feb 2002 07:32:18 -0500
Received: from host213-121-105-236.in-addr.btopenworld.com ([213.121.105.236]:43874
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S288946AbSBDMb5>; Mon, 4 Feb 2002 07:31:57 -0500
Subject: Re: How to crash a system and take a dump?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: sathish jayapalan <sathish_jayapalan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020204112621.31480.qmail@web14805.mail.yahoo.com>
In-Reply-To: <20020204112621.31480.qmail@web14805.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 04 Feb 2002 12:31:55 +0000
Message-Id: <1012825915.30112.4.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-04 at 11:26, sathish jayapalan wrote:
> Hi,
> I have a doubt. I know that linux kernel doesn't crash
> so easily. Is there any way to panic the system? Can I
> go to the source area and insert/modify a variable in
> kernel code so that the kernel references a null
> pointer and crashes while running the kernel compiled
> with this variable. My aim is to learn crash dump
> analysis with 'Lcrash tool". Please help me out with
> this.

Im not sure about the Lcrash tool, but core dumps can be obtained from
the kernel at any time simply by reading /proc/kcore.

Hope that helps.

-- 
// Gianni Tedesco <gianni@ecsc.co.uk>
80% of all email is a figment of procmails imagination.

