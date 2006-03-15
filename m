Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752161AbWCOXb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWCOXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWCOXb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:31:58 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:51894 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752161AbWCOXb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:31:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KIAvgRXtdAMIo+goLssxa+qFocyr7lwTsO6cNauXzXnxfTC2PnC0gQSGkQQcPb28xCoNRjEI3UnQnlzD/J+qsCqUsY7AJ2ZvRqXiXvn5VYAkK9Bim45+x4T9RG0pzOKXK0+qV56CeYQwjBooCgxRZgOijMXlFORBb7iRVbrSMcI=  ;
Message-ID: <4418A3DC.9010809@yahoo.com.au>
Date: Thu, 16 Mar 2006 10:31:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ORMAP
References: <44178429.90808@comcast.net> <44180784.6020608@yahoo.com.au> <44183E75.3080406@comcast.net>
In-Reply-To: <44183E75.3080406@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

>Nick Piggin wrote:
>
>>2.6 has an object based rmap system working nicely for quite
>>a while now (though it was probably not exactly what you saw
>>in the -wli tree, but a derivative).
>>
>>It would be surprising if that made your system boot 3 times
>>faster though (unless it was on the edge of a swap storm or
>>something)
>>
>
>Dramatization.  It was probably around 30 seconds faster on a 2-3 minute
>boot sequence (I had a lot in rc.d), but it was noticeable :P
>
>I was wondering about that stuff.  There used to be a few cute things
>out there but I can't remember any of it now.  Page clustering etc etc.
>
>

Well I don't think any of that stuff was simply forgotten. Page 
clustering for
i386, for example became less important because of objrmap, reductions 
in size
of struct page, and the demise of insane highmem machines (due to x86-64).

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
