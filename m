Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSGTAcN>; Fri, 19 Jul 2002 20:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSGTAcN>; Fri, 19 Jul 2002 20:32:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53014 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317264AbSGTAcM>; Fri, 19 Jul 2002 20:32:12 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200207200035.g6K0ZFN11415@devserv.devel.redhat.com>
Subject: Re: [PATCH -ac] Panicking in morse code
To: arodland@noln.com (Andrew Rodland)
Date: Fri, 19 Jul 2002 20:35:15 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20020719011300.548d72d5.arodland@noln.com> from "Andrew Rodland" at Jul 19, 2002 01:13:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static const char * morse[] = {
> +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> +	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */
> +	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
> +	"-.--", "--..",	 	 	 	 	 	 /* Y-Z */
> +	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
> +	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */

How about using bitmasks here. Say top five bits being the length, lower
5 bits being 1 for dash 0 for dit ?


But very nice
