Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTLDSQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLDSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:16:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16076 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263441AbTLDSQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:16:09 -0500
Message-ID: <3FCF79E7.8080002@namesys.com>
Date: Thu, 04 Dec 2003 21:16:07 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kallol Biswas <kbiswas@neoscale.com>
CC: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
       Edward Shishkin <edward@namesys.com>
Subject: Re: partially encrypted filesystem
References: <1070485676.4855.16.camel@nucleon>
In-Reply-To: <1070485676.4855.16.camel@nucleon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Shushkin is working full-time on compression and encryption 
plugins for Reiser4, which are selected on a per file basis.  The 
compression and encryption is done at flush to disk time, rather than 
with each write, which means that repeated writes to the same object are 
done efficiently.  He has been working on it for a year, and sometime 
early next year he will have something usable you can try.:)

Hans



-- 
Hans


