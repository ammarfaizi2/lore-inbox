Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265548AbRGEXXd>; Thu, 5 Jul 2001 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265542AbRGEXXW>; Thu, 5 Jul 2001 19:23:22 -0400
Received: from jalon.able.es ([212.97.163.2]:22175 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265517AbRGEXXN>;
	Thu, 5 Jul 2001 19:23:13 -0400
Date: Fri, 6 Jul 2001 01:23:42 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010706012342.A12969@werewolf.able.es>
In-Reply-To: <9515.994372983@redhat.com> <XFMail.20010705155318.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <XFMail.20010705155318.davidel@xmailserver.org>; from davidel@xmailserver.org on Fri, Jul 06, 2001 at 00:53:18 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010706 Davide Libenzi wrote:
>
>On 05-Jul-2001 David Woodhouse wrote:
>> 
>> phillips@bonn-fries.net said:
>>> This program prints garbage:
>>>      #define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y);
>>>      #(_x>_y)?_y:_x; })
>>>              int main (void) { 
>>>              int _x = 3, _y = 4; 
>>>              printf("%i\n", min(_x, _y)); 
>>>              return 0; 
>>>      } 
>> 
>> Life's a bitch.
>> cf. get_user(__ret_gu, __val_gu); (on i386)
>> 
>> Time to invent a gcc extension which gives us unique names? :)
>
>Something like ::(x) to move up one level the name resolution for example.
>

Tell gcc people to support <? and >? in C besides C++.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac1 #2 SMP Thu Jul 5 01:15:49 CEST 2001 i686
