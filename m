Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163562AbWLGWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163562AbWLGWyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163560AbWLGWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:54:41 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:2983 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1163562AbWLGWyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:54:40 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH/RFC] CodingStyle updates
Date: Thu, 7 Dec 2006 22:54:51 +0000
User-Agent: KMail/1.9.5
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
In-Reply-To: <20061207004838.4d84842c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612072254.51348.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thursday 07 December 2006 08:48, Randy Dunlap wrote:
[snip]
> +		3.1:  Spaces
> +
> +Linux kernel style for use of spaces depends (mostly) on
> +function-versus-keyword usage.  Use a space after (most) keywords.
> +The notable exception is "sizeof", which looks like a function
> +(and is usually used with parentheses in Linux, although they are
> +not required in the language, as in: "sizeof struct file").
> +So use a space after these keywords:
> +	if, switch, case, for, do, while
> +but not with "sizeof".  E.g.,
> +	s = sizeof(struct file);
> +
> +Do not add spaces around (inside) parenthesized expressions.
> +This example is *bad*:
> +
> +	s = sizeof( struct file );
> +
> +When declaring pointer data or a function that returns a pointer type,
> +the preferred use of '*' is adjacent to the data name or function name
> +and not adjacent to the type name.  Examples:
> +
> +	char *linux_banner;
> +	unsigned long long memparse(char *ptr, char **retptr);
> +	char *match_strdup(substring_t *s);
> +
> +Use one space around (on each side of) most binary operators, such as
> +any of these:
> +		=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=
> +
> +but no space after unary operators:
> +		sizeof  ++  --  &  *  +  -  ~  !  defined

You could mention typeof too, which is a keyword but should be done like 
sizeof.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
