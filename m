Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVEJQan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVEJQan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVEJQan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:30:43 -0400
Received: from mail11.svc.cra.dublin.eircom.net ([159.134.118.27]:33092 "HELO
	mail11.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261705AbVEJQa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:30:27 -0400
Message-ID: <4280E1A9.3010703@propylon.com>
Date: Tue, 10 May 2005 17:30:33 +0100
From: Sean McGrath <sean.mcgrath@propylon.com>
Reply-To: sean.mcgrath@propylon.com
Organization: Propylon
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>	 <41A23496.505@namesys.com>  <1101287762.1267.41.camel@pear.st-and.ac.uk>	 <1115717961.3711.56.camel@grape.st-and.ac.uk>	 <4280CAEF.5060202@namesys.com> <1115739129.3711.117.camel@grape.st-and.ac.uk>
In-Reply-To: <1115739129.3711.117.camel@grape.st-and.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>On Tue, 2005-05-10 at 15:53, Hans Reiser wrote:
>  
>
>>I agree with the below in that sometimes you want to see a collection of
>>stuff as one file, and sometimes you want to see it as a tree, and that
>>file format browsers can be integrated into file system browsers to look
>>seamless to users.
>>
>>A quibble: A name is just a means to select a file; he is completely
>>wrong to think that file browsers will eliminate filenames.
>>    
>>
>
>Yes, even if you think of the whole file system as a single "file", you
>need a way to select the bit you need, and you will use names for that
>(and whether you call that a filename, a file-part name or an object
>name doesn't really matter).
>  
>
The thing that interests me most is the difference (if any) between 
giving a stream of bytes an opaque name e.g. "Chapter 1 of my book.sxw" 
versus giving a stream of bytes a query expression that can also be 
considered an opaque name e.g.
"/book/chapter[1] "

This is what the Russell/Frege descriptive theory of proper names 
applied to storage systems in a sense[1].

I've written about this stuff before on ITWorld (warning: chatty prose 
style ahead):

    Fractals, Self Similarity, and the Whimsical Boundaries of XML Documents
    http://www.itworld.com/nl/xml_prac/04252002/

    A study in XML culture and evolution
    http://www.itworld.com/nl/ebiz_ent/03252003/

[1] http://en.wikipedia.org/wiki/Proper_name

Sean


