Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWCVKps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWCVKps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWCVKps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:45:48 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:12344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbWCVKpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:45:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HlLQpeQFrZ64JORhjw0DoWI3u1ekW/8t9+xql5W8ZXm+zEgrXHrc6gltvk1AwBXUL461jBvXQ+EJnF4Vp3mY7GsYxsTC2HnHt1Eg3fOJljv7Nl29OV6OZEtPdYQ2aacARc52GMccOWJ9a7tt1BY6KkS/ApwptWWwt04oWPcg8+A=
Message-ID: <4fec73ca0603220245y72e66279jeaf93a944334a879@mail.gmail.com>
Date: Wed, 22 Mar 2006 11:45:43 +0100
From: "=?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?=" <glalejos@gmail.com>
To: "Sam Vilain" <sam@vilain.net>
Subject: Re: Introducting LXD
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <44208914.9020604@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4fec73ca0603210212m5b351a14t678ee6dc918a5eb2@mail.gmail.com>
	 <44208914.9020604@vilain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I could follow the link, but there was nothing really there in your
> post to make me want to bite.

O.K., I'll try to show some of the interesting aspects of LXD.

LXD intends to be a documentation system for large open source
projects. Its main objective is to gather high level information that
cannot be extracted from the source files.

The main strengths of LXD are:
    * Documentation is separated from source files:
        - High level information usually does not fit in a unique
source file (e.g.
          subsystem description).
        - Source code is more readable without big blocks of comments.

    * Documentation files have a well defined XML structure.
        - Provides developers a clear view of what has to be documented and how.
        - Documentation can be edited using standard XML editors.
        - It can be obtained lots of human readable documentation
formats (LaTeX, HTML, ...)
          from XML documents.
        - Documentation can be independent from programming language.

My initial idea of LXD is a system composed by the XML documents
definitions and a set of tools to ease the management of XML
documentation. To simplify the problem, the first approach will be
focused on projects written in C language. As I said in my previous
post, there is a presentation of the project at
http://lxd.sourceforge.net/.

The main aspects that I expect to discuss for user requirements
analysis are the XML documents definitions and also useful tools for
this system.

Best regards,

--
Guillermo
