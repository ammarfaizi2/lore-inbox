Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTEaGOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTEaGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:14:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:30085 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264151AbTEaGOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:14:17 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <1054342517.2901.78.camel@spc>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19Lzpz-00011a-00@calista.inka.de>
Date: Sat, 31 May 2003 08:27:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1054342517.2901.78.camel@spc> you wrote:
> +Function declarations should be new-style:
> +
> +int foo(long bar, long baz, struct magic *xyzzy)
...

I would suggest to include the comment based linux document boiler plates
into that coding style recommendation. In that case it is clear, how you can
document the parameters of a function.

/**
 * foo: - do a foo job
 * @parameterbar: the bar parameter is used to bar
 *
 * Description: This is the long description of the function foo() which
 *   is closely related to bar()
 * section header: section description
 **/
int foo(long bar, long baz, struct magic *xyzzy)


(I am not sure about the section, and it most likely is helpful to include a
comment, that not all functions should be documented that way.

I realy think it is important to have at least a pointer from the coding
style document to the doc-comments.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
