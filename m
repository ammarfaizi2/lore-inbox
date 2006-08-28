Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWH1KzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWH1KzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWH1KzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:55:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:5075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964792AbWH1KzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:55:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AI8+OhAHh7W2W+LcR/j/xtyK13EwezTN8NNo7pUlqww/aC0ev/ZhMgTSjN2BWTp5OgsGlIndhbzxs9girTx6Zk2y0LE4c+6tTTxsmSWFU8A0M7OvPkVfmxKp455Sbq8aFOMtblXW/W/F18sl9H7XS77nSbSPUAYNL02y3MiaFZQ=
Message-ID: <44F2CB80.1090902@gmail.com>
Date: Mon, 28 Aug 2006 12:54:33 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: altendew <andrew@shiftcode.com>, linux-kernel@vger.kernel.org
Subject: Re: Server Attack
References: <6011508.post@talk.nabble.com> <44F259C7.5090505@wolfmountaingroup.com>
In-Reply-To: <44F259C7.5090505@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey V. Merkey wrote:
> altendew wrote:
> 
>> Hi someone is currently sending requests to our server 20x a second.
>>
>> Here is what one of the logs look like.
>>
>> [CODE]
>> Host: 84.77.19.46   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; MTQ; PPC Mac OS 
>> X; en-US) AppleWebKit/578.4
>> (KHTML, like Geco, Safari) OmniWeb/v643.68e=C: 
>> Host: 82.234.98.65   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; CDB; PPC Mac OS 
>> X; en-US) AppleWebKit/126.0
>> (KHTML, like Geco, Safari) OmniWeb/v554.35 
>> Host: 84.94.31.161   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; TLD; PPC Mac OS 
>> X; en-US) AppleWebKit/502.6
>> (KHTML, like Geco, Safari) OmniWeb/v401.63ive=C: 
>> Host: 81.49.24.92   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; SZS; PPC Mac OS 
>> X; en-US) AppleWebKit/230.1
>> (KHTML, like Geco, Safari) OmniWeb/v710.56ive=C: 
>> Host: 80.129.248.17   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; OST; PPC Mac OS 
>> X; en-US) AppleWebKit/243.6
>> (KHTML, like Geco, Safari) OmniWeb/v846.88 
>> Host: 87.235.49.194   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.1  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; SDD; PPC Mac OS 
>> X; en-US) AppleWebKit/430.1
>> (KHTML, like Geco, Safari) OmniWeb/v145.34 
>> Host: 125.129.12.61   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; WCG; PPC Mac OS 
>> X; en-US) AppleWebKit/455.3
>> (KHTML, like Geco, Safari) OmniWeb/v042.84stemDrive=\x81 
>> Host: 66.110.153.47   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; ZAM; PPC Mac OS 
>> X; en-US) AppleWebKit/387.2
>> (KHTML, like Geco, Safari) OmniWeb/v456.02ve=C: 
>> Host: 62.2.177.250   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:38  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; LMZ; PPC Mac OS 
>> X; en-US) AppleWebKit/206.1
>> (KHTML, like Geco, Safari) OmniWeb/v204.07es 
>> Host: 200.115.226.143   /signUp.php?ref=1945777   Http Code: 403  
>> Date: Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; EDE; PPC Mac OS 
>> X; en-US) AppleWebKit/647.0
>> (KHTML, like Geco, Safari) OmniWeb/v760.47emDrive=C:\x81 
>> Host: 84.171.125.189   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; QHA; PPC Mac OS 
>> X; en-US) AppleWebKit/778.0
>> (KHTML, like Geco, Safari) OmniWeb/v456.03=C: 
>> Host: 83.242.79.70   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; GFS; PPC Mac OS 
>> X; en-US) AppleWebKit/537.0
>> (KHTML, like Geco, Safari) OmniWeb/v313.01rive=C: 
>> Host: 86.69.194.172   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; ZCV; PPC Mac OS 
>> X; en-US) AppleWebKit/468.2
>> (KHTML, like Geco, Safari) OmniWeb/v026.14stemDrive=\x81 
>> Host: 196.203.176.26   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; BXT; PPC Mac OS 
>> X; en-US) AppleWebKit/840.3
>> (KHTML, like Geco, Safari) OmniWeb/v767.50s 
>> Host: 201.41.241.190   /signUp.php?ref=1945777   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.0  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0 (Macintosh; TYZ; PPC Mac OS 
>> X; en-US) AppleWebKit/742.0
>> (KHTML, like Geco, Safari) OmniWeb/v715.65C: 
>> Host: 200.84.144.234   /signUp.php?ref=ec0lag   Http Code: 403  Date: 
>> Aug 27 17:44:37  Http Version: HTTP/1.1  Size in
>> Bytes: -   Referer: -   Agent: Mozilla/5.0  [/CODE]
>>
>> We are currently blocking this user through our Apache.
>>
>> .htaccess
>> [CODE]
>> RewriteEngine On RewriteCond %{HTTP_USER_AGENT} ^Mozilla/5\.0\ 
>> \(Macintosh;\ (.+)\ PPC\ Mac\
>> OS\ X;\ en-US\)\ AppleWebKit/(.+)\ \(KHTML,\ like\ Geco,\ Safari\)\
>> OmniWeb/v([0-9]+).([0-9]+)(.+)$
>> RewriteRule .* - [F]
>> [/CODE]
>>
>> That works fine and is giving the user a 403 (Forbidden), but the 
>> problem is
>> that half of our Apache processes are from this user.
>>
>> Is there a way to block his user agent before he gets to Apache? 
>> Sometimes
>> this brings our server to a crash.
>>
>> Thanks
>> Andrew
>>  
>>
> iptables -J drop <ip address>

Too slow, iptables' rules are (or was, at least) traversed sequentially. Better 
is routing table with blackhole-rule used for these IPs.

Problem is, that IPs are variable, but use of some scripting solves this...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
