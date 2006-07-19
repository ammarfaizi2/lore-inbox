Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWGSTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWGSTxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWGSTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 15:53:19 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:13953 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1030256AbWGSTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 15:53:19 -0400
Message-ID: <44BE9620.9080400@wolfmountaingroup.com>
Date: Wed, 19 Jul 2006 14:29:20 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Tilman Schmidt <tilman@imap.cc>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org> <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>            <44BE50A0.9070107@imap.cc> <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu>
In-Reply-To: <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A big ego thing I guess. 

Keeping a lot of FS's and code out of tree has a lot of advatanges (like 
not getting targeted by folks
claiming IP issues suing Linus and Co.).    I am still distributing NWFS 
out of the tree, and there's still 2000+ downloads per month from
three separate locations -- code I have not touched in three years.   

Projects I have taken commercial are big money makers and obviously will 
not be submitted to the tree.  Reiser is shipped in Suse
Linux as the default, so who cares whether its in the tree or not -- it 
still has succeeded.  You guys should keep the stuff out of the tree
(in fact most of the FS's and other code should not be in the tree).

The whole Linux base is too big as it is and becoming larger.  Only 
minimal drivers and FS's should be in the tree.  Less broken stuff
and dependencies.  I have been watching development cycles take longer 
and longer to get Linux kernels out -- Red Hat is STILL
shipping 2.6.9-22 with ES4 (update kernels have various issues of 
stability).

The smaller the better.    You have more control if you keep it out, and 
greater opporutnities for serious folks to do business
deals to promote your stuff.

Jeff

Valdis.Kletnieks@vt.edu wrote:

>On Wed, 19 Jul 2006 17:32:48 +0200, Tilman Schmidt said:
> 
>  
>
>>Well, that doesn't make sense. You can't have your cake and eat it
>>too. Either you have out-of-tree code or you haven't. Documents
>>like stable_api_nonsense.txt explicitly discourage out-of-tree code,
>>which is formally equivalent to saying that all kernel code should
>>be in-tree. Therefore an attitude which says "go on developing that
>>code out-of-tree, it's not ready for inclusion yet" is in direct
>>contradiction with the foundations of the no-stable-API policy.
>>    
>>
>
>Which part of "read Documentation/SubmittingPatches.txt and do what it says,
>or it doesn't get into the kernel" do you have trouble understanding?
>
>It isn't a case of "out of tree code or you haven't". There's actually
>*three* major categories:
>
>1) Code that's already in-tree and maintained.  These guys don't need to
>worry about the API, as it will usually get handled free of charge.
>
>2) Code that's out-of-tree, but a potential (after possible rework) candidate
>for submission (for instance, the hi-res timers, CKRM, some drivers, etc).
>These guys need to forward-port their code for API changes as they work
>towards getting their code into the tree.
>
>3) Code that's out-of-tree, but is so far out in left field that there's
>no way it will ever go in.  For instance, that guy with the MVS JCL emulator
>better not be holding his breath waiting.  And quite frankly, nobody else
>really cares whether they forward port their code or not.
>  
>

