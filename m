Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUKZTAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUKZTAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKZS7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 13:59:46 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40182 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261153AbUKZS7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 13:59:30 -0500
Message-ID: <41A7562C.2000906@namesys.com>
Date: Fri, 26 Nov 2004 08:13:32 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>	 <41A23496.505@namesys.com> <1101287762.1267.41.camel@pear.st-and.ac.uk>	 <4d8e3fd304112407023ff0a33d@mail.gmail.com> <1101309954.2779.15.camel@pear.st-and.ac.uk>
In-Reply-To: <1101309954.2779.15.camel@pear.st-and.ac.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>On Wed, 2004-11-24 at 15:02, Paolo Ciarrocchi wrote:
>  
>
>>On 24 Nov 2004 09:16:03 +0000, Peter Foldiak
>><peter.foldiak@st-andrews.ac.uk> wrote:
>>[...] 
>>    
>>
>>>I would really like to implement this for the next version of Hans' file
>>>system.
>>>      
>>>
>>I don't undersand how you want to use Xpath for not XML file.
>>I agree with you that the idea behind Xpath is cool but I fail to
>>unserstand how it can be applied to anything but XML
>>    
>>
>
>My message was mainly about XML, for which it is easy.
>For non-XML, you need some other way of knowing the file format. The
>example that originally came up in this thread was
>
>/etc/passwd/[username]
>
>In this case, the passwd file has a known format.
>Other file types, like LaTex, html, jpeg also have (at least partially)
>known formats. Some selection should be possible even for unknown
>formats (e.g. byte range, line-range). There could also be some way of
>specifying a new format but I don't know how to do this well. You could
>give names (like filenames) to parts of files.
>But I think the first step would be to concentrate on XML, and worry
>about the rest later.   Peter
>
>
>
>  
>
I think Peter is right.  It would be nice to have an interpreter for 
each of the common file formats, and  XML is just the biggest one.
