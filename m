Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTEaHEe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTEaHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:04:34 -0400
Received: from quechua.inka.de ([193.197.184.2]:45192 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264181AbTEaHEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:04:33 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <E19Lzpz-00011a-00@calista.inka.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19M0cj-0001CK-00@calista.inka.de>
Date: Sat, 31 May 2003 09:17:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E19Lzpz-00011a-00@calista.inka.de> you wrote:
> /**
> * foo: - do a foo job
> * @parameterbar: the bar parameter is used to bar
> *
> * Description: This is the long description of the function foo() which
> *   is closely related to bar()
> * section header: section description
> **/
> int foo(long bar, long baz, struct magic *xyzzy)

most likely I made an error here:

/**
* foo: - do a foo job
* @bar: the bar parameter is used to bar
*
* Description: This is the long description of the function foo() which
*   is closely related to bar(). @baz may not be 0.
* section header: section description
**/

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
