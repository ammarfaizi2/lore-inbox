Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUINIhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUINIhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269243AbUINIhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:37:19 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:31493 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269208AbUINIeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:34:23 -0400
Message-ID: <4146AE28.1050004@hist.no>
Date: Tue, 14 Sep 2004 10:39:04 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Elladan <elladan@eskimo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org> <414176F2.3030301@hist.no> <20040910201738.GB8698@eskimo.com>
In-Reply-To: <20040910201738.GB8698@eskimo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan wrote:

>
>>What's wrong with using / as the separator?  It is already
>>used to separate components of pathnames.  Named streams
>>are very much like files in a subdirectory.
>>
>>This scheme makes for very little change to existing tools,
>>users may then do a "gimp somefile/icon.jpg"  for example.
>>Or "ls somefile/*" to see all the named streams/forks.
>>    
>>
>
>Directories may have metadata as well.
>  
>
They can. That doesn't stand in the way of using "/" to separate
the named stream's name from the file (or directory) that
have the attribute.  "Directories may have metadata" pops
up now and then, and the solution is so blindlingly obvious
that nobody sees it.

A file-as-dir can be implemented as a rather normal directory
attached to the file's name.  The stuff inside may
be interpreted as "attributes" or as something more file-like,
such as the often mentioned thumbnails.

What about a directory then?  It _is_ a directory, so it
support named streams already.  They are usually called "files". :-)
So, if you really want a thumb for your directory, just store a
thumb.jpg in it.

Helge Hafting


