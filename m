Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWBYRkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWBYRkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWBYRkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:40:43 -0500
Received: from smtp.e7even.com ([83.151.192.19]:3723 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S932636AbWBYRkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:40:42 -0500
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: reiserfs-list@namesys.com, Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: creating live virtual files by concatenation
Date: Sat, 25 Feb 2006 17:40:17 +0000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1271316508.20060225153749@dns.toxicfilms.tv>
In-Reply-To: <1271316508.20060225153749@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251740.18712.Peter.Foldiak@st-andrews.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, I think it is a good idea but there has been quite a long discusion of 
this issue on the reiserfs-list (some of it also on lkml) in the last few 
years, with the latest posts in May 2005 I think, most of ithem with the 
"file as directory" subject . The idea was if you have e.g. a "book" 
directory/file (object) and chapters within it, then the default action of 
"book" object when read as a file would be to give a concatenation of the 
chapter objects within it. There should be ways of specifying non-default 
actions for the objects too. There has also been a lot a resistance here to 
this idea, as it is quite a radical change to the concept of the conventional 
unstructured, serial "file". (I don't believe these are good reason not to 
try the idea at least.)
Read those mails first. Peter

On Saturday 25 February 2006 14:37, Maciej Soltysiak wrote:
> I have this idea about creating sort of a virtual file.
